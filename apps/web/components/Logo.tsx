/**
 * Freedom Tree's only available logo asset is a white SVG made for colored
 * backgrounds. Until a colored/dark variant is supplied, we place it inside
 * a solid ft-orange badge so it also works on the dashboard's white nav bar.
 */
export function Logo({ className = "" }: { className?: string }) {
  return (
    <div
      className={`inline-flex items-center gap-2 rounded-md bg-ft-orange px-3 py-1.5 ${className}`}
    >
      <img src="/brand/ft-logo-white.svg" alt="Freedom Tree" className="h-5 w-auto" />
    </div>
  );
}
