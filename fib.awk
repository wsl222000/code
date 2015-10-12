function fibo(n) {
  if(n<=1) return 1;
  return (fibo(n-2) + fibo(n-1));
}
BEGIN {
  n=(ARGV[1] < 1) ? 1 : ARGV[1];
  printf ("%d\n", fibo(n));
  exit;
}
