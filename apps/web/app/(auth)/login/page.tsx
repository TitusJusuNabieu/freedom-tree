"use client";

import { useState } from "react";
import { signIn } from "next-auth/react";
import { useRouter } from "next/navigation";
import { Eye, EyeOff, AlertCircle } from "lucide-react";
import { Logo } from "@/components/Logo";

export default function LoginPage() {
  const router = useRouter();
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError(null);
    setLoading(true);
    const result = await signIn("credentials", { username, password, redirect: false });
    setLoading(false);
    if (result?.error) {
      setError("Invalid username or password. Please try again.");
      return;
    }
    router.push("/");
    router.refresh();
  }

  return (
    <div className="flex min-h-screen">
      {/* Left branding panel — hidden on small screens */}
      <div className="hidden flex-col justify-between bg-ft-grey-darker p-10 lg:flex lg:w-[420px]">
        <Logo />
        <div>
          <blockquote className="space-y-4">
            <p className="text-lg leading-relaxed text-white/80">
              &ldquo;Every data point represents a mother and a child. Accurate
              reporting saves lives.&rdquo;
            </p>
            <footer className="text-sm text-white/50">Freedom Tree Health Initiative</footer>
          </blockquote>
        </div>
        <div className="space-y-1 text-xs text-white/30">
          <p>Freedom Tree — Canada &amp; Sierra Leone</p>
          <p>Maternal &amp; Infant Mortality Reporting System</p>
        </div>
      </div>

      {/* Right form panel */}
      <div className="flex flex-1 flex-col items-center justify-center bg-white px-6 py-12">
        <div className="w-full max-w-sm">
          {/* Logo — visible only on mobile where the side panel is hidden */}
          <div className="mb-8 flex justify-center lg:hidden">
            <Logo />
          </div>

          <div className="mb-8">
            <h1 className="text-2xl font-semibold text-ft-grey-darker">Sign in</h1>
            <p className="mt-1 text-sm text-ft-grey-medium">
              Access the Freedom Tree reporting dashboard
            </p>
          </div>

          <form onSubmit={handleSubmit} className="space-y-5">
            <div className="space-y-1">
              <label htmlFor="username" className="block text-sm font-medium text-ft-grey-dark">
                Username
              </label>
              <input
                id="username"
                type="text"
                autoComplete="username"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                required
                className="w-full rounded-lg border border-ft-grey-light bg-white px-4 py-2.5 text-ft-grey-darker placeholder-ft-grey-light outline-none transition focus:border-ft-orange focus:ring-2 focus:ring-ft-orange/20"
                placeholder="your.username"
              />
            </div>

            <div className="space-y-1">
              <label htmlFor="password" className="block text-sm font-medium text-ft-grey-dark">
                Password
              </label>
              <div className="relative">
                <input
                  id="password"
                  type={showPassword ? "text" : "password"}
                  autoComplete="current-password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  required
                  className="w-full rounded-lg border border-ft-grey-light bg-white px-4 py-2.5 pr-12 text-ft-grey-darker outline-none transition focus:border-ft-orange focus:ring-2 focus:ring-ft-orange/20"
                  placeholder="••••••••"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword((v) => !v)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-ft-grey-medium transition hover:text-ft-grey-darker"
                  aria-label={showPassword ? "Hide password" : "Show password"}
                >
                  {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                </button>
              </div>
            </div>

            {error && (
              <div className="flex items-start gap-2 rounded-lg border border-ft-dark-orange/30 bg-ft-dark-orange/5 px-4 py-3">
                <AlertCircle size={16} className="mt-0.5 shrink-0 text-ft-dark-orange" />
                <p className="text-sm text-ft-dark-orange">{error}</p>
              </div>
            )}

            <button
              type="submit"
              disabled={loading || !username || !password}
              className="relative w-full overflow-hidden rounded-lg bg-ft-orange px-4 py-2.5 text-sm font-semibold text-white shadow-sm transition hover:bg-ft-dark-orange focus:outline-none focus:ring-2 focus:ring-ft-orange focus:ring-offset-2 disabled:opacity-60"
            >
              {loading ? (
                <span className="flex items-center justify-center gap-2">
                  <span className="h-4 w-4 animate-spin rounded-full border-2 border-white/30 border-t-white" />
                  Signing in…
                </span>
              ) : (
                "Sign in"
              )}
            </button>
          </form>

          <p className="mt-8 text-center text-xs text-ft-grey-light">
            Field workers log in via the mobile app
          </p>
        </div>
      </div>
    </div>
  );
}
