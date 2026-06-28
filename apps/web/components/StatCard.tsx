export function StatCard({ label, value, suffix }: { label: string; value: number; suffix?: string }) {
  return (
    <div className="rounded-lg border border-ft-grey-light p-4">
      <p className="text-sm text-ft-grey-medium">{label}</p>
      <p className="mt-1 text-2xl font-semibold text-ft-grey-darker">
        {value.toLocaleString()}{suffix}
      </p>
    </div>
  );
}
