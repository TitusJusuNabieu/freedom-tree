import type { Metadata } from "next";
import { Zilla_Slab, Open_Sans } from "next/font/google";
import { Providers } from "@/components/Providers";
import "./globals.css";

const zillaSlab = Zilla_Slab({
  variable: "--font-zilla-slab",
  subsets: ["latin"],
  weight: ["500", "600", "700"],
});

const openSans = Open_Sans({
  variable: "--font-open-sans",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "Freedom Tree | Reporting Dashboard",
  description: "Monthly maternal and infant mortality reporting for Freedom Tree",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className={`${zillaSlab.variable} ${openSans.variable} h-full antialiased`}>
      <body className="min-h-full flex flex-col bg-white text-ft-grey-darker">
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}
