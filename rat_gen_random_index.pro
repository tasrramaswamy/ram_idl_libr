function rat_gen_random_index , N ,M 
;This function returns M random indices , in an array of length N
; Note always N>M
; This is reproduced as-is from David Fanning's website:
;http://www.idlcoyote.com/code_tips/randomindex.html - date 26 May 2015
seed=123456
 randomNumbers = RANDOMU(seed, N)            
sortedRandomNumbers = SORT(randomNumbers)     
indices = sortedRandomNumbers[0:M-1]  
return,indices
end
