install.packages("SnowballC")

library(tm)
library(wordcloud)
library(stringr)
library(RXKCD)
library(SnowballC)
library(RColorBrewer)

file.choose()
folder<- "C:\\Users\\Avirat\\Desktop\\Text"

corpus<- VCorpus(DirSource(folder))
inspect(corpus)

stop<- stopwords( kind = "en")
mystop<- c("Target","Marketing")
stop[1:50]

corpus_transform <- tm_map(corpus, content_transformer(stripWhitespace) ) #Removing Whitespace
corpus_transform <- tm_map(corpus_transform, content_transformer(tolower) ) #Comverting to lower text
corpus_transform <- tm_map(corpus_transform, content_transformer(removePunctuation) ) #Removing Punctuation
corpus_transform <- tm_map(corpus_transform, removeWords,c(stopwords("english"),"tmmapcorpustransform","corpustransform")) #Removing Stopwords
corpus_transform <- tm_map(corpus_transform, content_transformer(stemDocument)) #Stemming the document
tweet_plot<-corpus_transform

tdm <- TermDocumentMatrix(corpus_transform)
inspect(tdm)

m <- as.matrix(tdm)
v <- sort(rowSums(m), decreasing=TRUE)
d <- data.frame(word=names(v), freq=v, stringsAsFactors=FALSE)
head(d)

#Creating the wordcloud
pal <- brewer.pal(8,"Dark2")
wordcloud(tweet_plot,  random.order = F, max.words = 50, scale = c(3,0.5), colors = pal)
