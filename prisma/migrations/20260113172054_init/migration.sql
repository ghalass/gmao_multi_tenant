/*
  Warnings:

  - A unique constraint covering the columns `[tenantId,name]` on the table `typeparc` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `tenantId` to the `typeparc` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "typeparc" ADD COLUMN     "tenantId" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "typeparc_tenantId_name_key" ON "typeparc"("tenantId", "name");

-- AddForeignKey
ALTER TABLE "typeparc" ADD CONSTRAINT "typeparc_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;
