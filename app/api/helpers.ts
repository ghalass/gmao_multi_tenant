import { getSession } from "@/lib/auth";
import { prisma } from "@/lib/prisma";
import { NextResponse } from "next/server";

export const checkTenant = async () => {
  const session = await getSession();
  if (!session?.tenant.id) {
    return NextResponse.json(
      { message: "Ce nom d'entreprise n'existe pas" },
      { status: 404 }
    );
  }
  // Vérifier si le tenant existe déjà
  const tenant = await prisma.tenant.findUnique({
    where: { id: session?.tenant.id },
  });
  if (!tenant) {
    return NextResponse.json(
      { message: "Ce nom d'entreprise n'existe pas" },
      { status: 404 }
    );
  }
};
