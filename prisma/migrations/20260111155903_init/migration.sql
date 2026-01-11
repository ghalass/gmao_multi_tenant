/*
  Warnings:

  - Added the required column `dateDetection` to the `anomalie` table without a default value. This is not possible if the table is not empty.
  - Added the required column `source` to the `anomalie` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "anomalie" ADD COLUMN     "besoinPDR" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "code" TEXT,
ADD COLUMN     "confirmation" TEXT,
ADD COLUMN     "dateDetection" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "dateExecution" TIMESTAMP(3),
ADD COLUMN     "equipe" TEXT,
ADD COLUMN     "numeroBS" TEXT,
ADD COLUMN     "observations" TEXT,
ADD COLUMN     "programmation" TEXT,
ADD COLUMN     "quantite" INTEGER,
ADD COLUMN     "reference" TEXT,
ADD COLUMN     "sortiePDR" TEXT,
ADD COLUMN     "source" "SourceAnomalie" NOT NULL,
ADD COLUMN     "stock" TEXT;
