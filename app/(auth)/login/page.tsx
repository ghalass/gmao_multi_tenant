"use client";

import * as React from "react";
import { useForm } from "@tanstack/react-form";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import {
  Field,
  FieldError,
  FieldGroup,
  FieldLabel,
} from "@/components/ui/field";
import { Input } from "@/components/ui/input";

import ModeToggle from "@/components/ModeToggle";
import yup from "@/lib/yupFr";
import { useAuth } from "@/hooks/useAuth";
import { Spinner } from "@/components/ui/spinner";
import Link from "next/link";
import { useRouter } from "next/navigation"; // Ajouté pour la redirection
import { toast } from "sonner";
import { useMutation } from "@tanstack/react-query";
import { FormField } from "@/components/form/FormField";
import { ROUTE } from "@/lib/routes";
import { useUser } from "@/context/UserContext";

interface loginPayload {
  email: string;
  password: string;
  tenantName: string;
}

export default function LoginPage() {
  const [error, setError] = React.useState<string | null>(null);
  const { refreshUser } = useUser();

  const { login } = useAuth();
  const router = useRouter(); // Pour la redirection après connexion

  // ✅ Yup schema
  const loginSchema = React.useMemo(() => {
    return yup.object({
      email: yup.string().email().required().label("Email"),
      password: yup.string().min(6).required().label("Mot de passe"),
      tenantName: yup.string().required().label("Entreprise"),
    });
  }, []);

  // ✅ Mutation TanStack Query
  const loginMutation = useMutation({
    mutationFn: async (payload: loginPayload) => {
      const success = await login(
        payload.email,
        payload.password,
        payload.tenantName
      );
      if (!success) {
        throw new Error("Échec de la connexion. Vérifiez vos identifiants.");
      }
    },
    onSuccess: () => {
      form.reset();
      toast.success("Connecté avec succès");
      refreshUser();
      router.push(ROUTE.MAIN); // ou router.refresh() pour revalider les données
    },
    onError: (err: any) => {
      setError(err.message || "Erreur lors de la création");
    },
  });

  // ✅ Configuration du formulaire TanStack avec validation
  const form = useForm({
    defaultValues: {
      email: "",
      password: "",
      tenantName: "",
    },
    onSubmit: async ({ value }) => {
      try {
        setError(null);
        await loginSchema.validate(value, { abortEarly: false });
        loginMutation.mutate(value);
      } catch (err: any) {
        if (err.name === "ValidationError") {
          setError(err.errors.join(", "));
        } else {
          setError(err.message || "Erreur lors de la création");
        }
      }
    },
  });

  // Fonction de validation pour chaque champ
  const validateField = React.useCallback(
    (fieldName: string, value: any) => {
      try {
        loginSchema.validateSyncAt(fieldName, { [fieldName]: value });
        return undefined;
      } catch (err: any) {
        return err.message;
      }
    },
    [loginSchema]
  );

  const handleReset = () => {
    form.reset();
    setError(null);
  };

  const isSubmitting = loginMutation.isPending;

  return (
    <div className="min-h-screen flex flex-col gap-4 items-center justify-center p-4">
      <div className="self-center">
        <ModeToggle />
      </div>

      <Card className="w-full max-w-md">
        <CardHeader>
          <CardTitle className="text-2xl text-center">Se connecter</CardTitle>
          <CardDescription className="text-center">
            Entrez vos identifiants pour accéder à votre compte.
          </CardDescription>
          {error && (
            <div className="mt-2 p-3 bg-destructive/10 border border-destructive rounded-md">
              <p className="text-sm text-destructive text-center">{error}</p>
            </div>
          )}
        </CardHeader>

        <CardContent>
          <form
            id="login-form"
            onSubmit={(e) => {
              e.preventDefault();
              e.stopPropagation();
              form.handleSubmit();
            }}
          >
            <FieldGroup className="gap-1">
              <FormField
                form={form}
                name="email"
                label="Email"
                customValidator={(value) => validateField("email", value)}
                disabled={isSubmitting}
              />
              <FormField
                form={form}
                name="password"
                label="Mot de passe"
                type="password"
                customValidator={(value) => validateField("password", value)}
                disabled={isSubmitting}
              />
              <FormField
                form={form}
                name="tenantName"
                label="Entreprise"
                type="tenantName"
                customValidator={(value) => validateField("tenantName", value)}
                disabled={isSubmitting}
              />
            </FieldGroup>
          </form>
        </CardContent>

        <CardFooter className="flex flex-col gap-4">
          <div className="w-full">
            <Button
              type="submit"
              form="login-form"
              disabled={isSubmitting}
              className="w-full"
            >
              {isSubmitting ? (
                <span className="flex items-center justify-center gap-2">
                  <Spinner className="h-4 w-4" /> Connexion...
                </span>
              ) : (
                "Se connecter"
              )}
            </Button>
          </div>

          <div className="flex justify-center w-full">
            <Button
              disabled={isSubmitting}
              type="button"
              variant="outline"
              onClick={handleReset}
              size="sm"
            >
              Réinitialiser
            </Button>
          </div>

          <div className="text-center space-y-2 text-sm">
            <p className="text-muted-foreground">
              Pas de compte ?{" "}
              <Link
                href="/register"
                className="text-primary hover:underline font-medium"
              >
                S&apos;inscrire
              </Link>
            </p>
            <p className="text-muted-foreground">
              <Link
                href="/"
                className="text-primary hover:underline font-medium"
              >
                Retour à la page d&apos;accueil
              </Link>
            </p>
          </div>
        </CardFooter>
      </Card>
    </div>
  );
}
