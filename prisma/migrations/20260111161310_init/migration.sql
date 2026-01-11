/*
  Warnings:

  - You are about to drop the column `initialHeureChassis` on the `organe` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "engin" ADD COLUMN     "initialHeureChassis" DOUBLE PRECISION DEFAULT 0;

-- AlterTable
ALTER TABLE "organe" DROP COLUMN "initialHeureChassis",
ADD COLUMN     "hrm_initial" DECIMAL(65,30) NOT NULL DEFAULT 0;
