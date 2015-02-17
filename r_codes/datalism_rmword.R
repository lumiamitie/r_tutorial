rm = c("a","b","c","d")
atoz = paste(letters,collapse="")
atoz
gsub(paste(rm, collapse="|"), "", atoz)

gsub("[^[a-z]+$]", "","111111  aaaa111aaaa aaa")
gsub("[[:digit:]]", "","111111  aaaa111aaaa aaa")

rm_word = c("단어", "어려운")
sentence = "단어 어려운 단어를 지우자"
gsub(paste(rm_word, collapse="|"), "", sentence)

rm_word = c("단어", "어려운")
words = c("단어", "어려운", "단어를", "지우자")
gsub(paste(rm_word, collapse="|"), "", words)
gsub(paste("^",rm_word,"$", sep="", collapse="|"), "", words)
