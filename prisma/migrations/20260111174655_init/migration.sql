/*
  Warnings:

  - You are about to drop the `typeconsommation_lub_parc` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "typeconsommation_lub_parc" DROP CONSTRAINT "typeconsommation_lub_parc_parc_id_fkey";

-- DropForeignKey
ALTER TABLE "typeconsommation_lub_parc" DROP CONSTRAINT "typeconsommation_lub_parc_tenantId_fkey";

-- DropForeignKey
ALTER TABLE "typeconsommation_lub_parc" DROP CONSTRAINT "typeconsommation_lub_parc_typeconsommationlub_id_fkey";

-- DropTable
DROP TABLE "typeconsommation_lub_parc";

-- CreateTable
CREATE TABLE "_ParcToTypeconsommationlub" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_ParcToTypeconsommationlub_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "_ParcToTypeconsommationlub_B_index" ON "_ParcToTypeconsommationlub"("B");

-- AddForeignKey
ALTER TABLE "_ParcToTypeconsommationlub" ADD CONSTRAINT "_ParcToTypeconsommationlub_A_fkey" FOREIGN KEY ("A") REFERENCES "parc"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ParcToTypeconsommationlub" ADD CONSTRAINT "_ParcToTypeconsommationlub_B_fkey" FOREIGN KEY ("B") REFERENCES "typeconsommation_lub"("id") ON DELETE CASCADE ON UPDATE CASCADE;
