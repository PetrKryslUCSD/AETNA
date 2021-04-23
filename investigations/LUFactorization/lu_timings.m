% Run comparison timings of LU factorization algorithms
function lu_timings
time_lu(@lu)
time_lu(@tcodes_slu)
time_lu(@naivelu)
time_lu(@naivelu1)
time_lu(@naivelu2)
time_lu(@naivelu3)
time_lu(@naivelu4)
time_lu(@lutxnopiv)
