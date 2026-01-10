/*
  Warnings:

  - The primary key for the `lubrifiant_parc` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `typeconsommation_lub_parc` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - A unique constraint covering the columns `[name,tenantId]` on the table `lubrifiant` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[organeId,enginId,date_mvt,type_mvt,tenantId]` on the table `mvt_organe` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[annee,parcId,siteId,tenantId]` on the table `objectif` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[name,typeOrganeId,tenantId]` on the table `organe` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[tenantId,name]` on the table `panne` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[resource,action,tenantId]` on the table `permission` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[organeId,date_mvt,type_rg,tenantId]` on the table `revision_organe` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[panneId,saisiehrmId,tenantId]` on the table `saisie_him` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[du,enginId,tenantId]` on the table `saisie_hrm` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[lubrifiantId,tenantId,saisiehimId,typeconsommationlubId]` on the table `saisie_lubrifiant` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[tenantId,anomalieId]` on the table `statut_anomalie` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[name,tenantId]` on the table `type_lubrifiant` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[name,tenantId]` on the table `type_organe` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[tenantId,name]` on the table `typeconsommation_lub` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[tenantId,name]` on the table `typepanne` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `tenantId` to the `lubrifiant_parc` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tenantId` to the `panne` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tenantId` to the `permission` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tenantId` to the `saisie_him` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tenantId` to the `saisie_hrm` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tenantId` to the `type_organe` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tenantId` to the `typeconsommation_lub` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tenantId` to the `typeconsommation_lub_parc` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tenantId` to the `typepanne` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "mvt_organe_organeId_enginId_date_mvt_type_mvt_key";

-- DropIndex
DROP INDEX "objectif_annee_parcId_siteId_key";

-- DropIndex
DROP INDEX "organe_name_typeOrganeId_key";

-- DropIndex
DROP INDEX "panne_name_key";

-- DropIndex
DROP INDEX "permission_resource_action_key";

-- DropIndex
DROP INDEX "revision_organe_organeId_date_mvt_type_rg_key";

-- DropIndex
DROP INDEX "saisie_him_panneId_saisiehrmId_key";

-- DropIndex
DROP INDEX "saisie_hrm_du_enginId_key";

-- DropIndex
DROP INDEX "type_organe_name_key";

-- DropIndex
DROP INDEX "typeconsommation_lub_name_key";

-- DropIndex
DROP INDEX "typepanne_name_key";

-- AlterTable
ALTER TABLE "lubrifiant_parc" DROP CONSTRAINT "lubrifiant_parc_pkey",
ADD COLUMN     "tenantId" TEXT NOT NULL,
ADD CONSTRAINT "lubrifiant_parc_pkey" PRIMARY KEY ("parc_id", "lubrifiant_id", "tenantId");

-- AlterTable
ALTER TABLE "panne" ADD COLUMN     "tenantId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "permission" ADD COLUMN     "tenantId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "saisie_him" ADD COLUMN     "tenantId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "saisie_hrm" ADD COLUMN     "tenantId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "type_organe" ADD COLUMN     "tenantId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "typeconsommation_lub" ADD COLUMN     "tenantId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "typeconsommation_lub_parc" DROP CONSTRAINT "typeconsommation_lub_parc_pkey",
ADD COLUMN     "tenantId" TEXT NOT NULL,
ADD CONSTRAINT "typeconsommation_lub_parc_pkey" PRIMARY KEY ("parc_id", "typeconsommationlub_id", "tenantId");

-- AlterTable
ALTER TABLE "typepanne" ADD COLUMN     "tenantId" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "lubrifiant_name_tenantId_key" ON "lubrifiant"("name", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "mvt_organe_organeId_enginId_date_mvt_type_mvt_tenantId_key" ON "mvt_organe"("organeId", "enginId", "date_mvt", "type_mvt", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "objectif_annee_parcId_siteId_tenantId_key" ON "objectif"("annee", "parcId", "siteId", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "organe_name_typeOrganeId_tenantId_key" ON "organe"("name", "typeOrganeId", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "panne_tenantId_name_key" ON "panne"("tenantId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "permission_resource_action_tenantId_key" ON "permission"("resource", "action", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "revision_organe_organeId_date_mvt_type_rg_tenantId_key" ON "revision_organe"("organeId", "date_mvt", "type_rg", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "saisie_him_panneId_saisiehrmId_tenantId_key" ON "saisie_him"("panneId", "saisiehrmId", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "saisie_hrm_du_enginId_tenantId_key" ON "saisie_hrm"("du", "enginId", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "saisie_lubrifiant_lubrifiantId_tenantId_saisiehimId_typecon_key" ON "saisie_lubrifiant"("lubrifiantId", "tenantId", "saisiehimId", "typeconsommationlubId");

-- CreateIndex
CREATE UNIQUE INDEX "statut_anomalie_tenantId_anomalieId_key" ON "statut_anomalie"("tenantId", "anomalieId");

-- CreateIndex
CREATE UNIQUE INDEX "type_lubrifiant_name_tenantId_key" ON "type_lubrifiant"("name", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "type_organe_name_tenantId_key" ON "type_organe"("name", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "typeconsommation_lub_tenantId_name_key" ON "typeconsommation_lub"("tenantId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "typepanne_tenantId_name_key" ON "typepanne"("tenantId", "name");

-- AddForeignKey
ALTER TABLE "permission" ADD CONSTRAINT "permission_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "typeconsommation_lub" ADD CONSTRAINT "typeconsommation_lub_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "typeconsommation_lub_parc" ADD CONSTRAINT "typeconsommation_lub_parc_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lubrifiant_parc" ADD CONSTRAINT "lubrifiant_parc_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "typepanne" ADD CONSTRAINT "typepanne_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "panne" ADD CONSTRAINT "panne_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "saisie_hrm" ADD CONSTRAINT "saisie_hrm_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "saisie_him" ADD CONSTRAINT "saisie_him_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "type_organe" ADD CONSTRAINT "type_organe_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;
