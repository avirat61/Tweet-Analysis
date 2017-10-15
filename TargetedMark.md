TargetedMark
================
Avirat Gaikwad
October 8, 2017

``` r
library(tm)
```

    ## Warning: package 'tm' was built under R version 3.4.2

    ## Loading required package: NLP

``` r
library(wordcloud)
```

    ## Warning: package 'wordcloud' was built under R version 3.4.2

    ## Loading required package: RColorBrewer

``` r
library(stringr)
```

    ## Warning: package 'stringr' was built under R version 3.4.2

``` r
library(RXKCD)
library(SnowballC)
library(RColorBrewer)
```

``` r
file.choose()
```

    ## [1] "C:\\Users\\Avirat\\Desktop\\Text\\TargetedMark2.txt"

``` r
folder<- "C:\\Users\\Avirat\\Desktop\\Text"

corpus<- VCorpus(DirSource(folder))
corpus
```

    ## <<VCorpus>>
    ## Metadata:  corpus specific: 0, document level (indexed): 0
    ## Content:  documents: 10

``` r
inspect(corpus)
```

    ## <<VCorpus>>
    ## Metadata:  corpus specific: 0, document level (indexed): 0
    ## Content:  documents: 10
    ## 
    ## [[1]]
    ## <<PlainTextDocument>>
    ## Metadata:  7
    ## Content:  chars: 39975
    ## 
    ## [[2]]
    ## <<PlainTextDocument>>
    ## Metadata:  7
    ## Content:  chars: 57062
    ## 
    ## [[3]]
    ## <<PlainTextDocument>>
    ## Metadata:  7
    ## Content:  chars: 6321
    ## 
    ## [[4]]
    ## <<PlainTextDocument>>
    ## Metadata:  7
    ## Content:  chars: 1375
    ## 
    ## [[5]]
    ## <<PlainTextDocument>>
    ## Metadata:  7
    ## Content:  chars: 1144
    ## 
    ## [[6]]
    ## <<PlainTextDocument>>
    ## Metadata:  7
    ## Content:  chars: 4807
    ## 
    ## [[7]]
    ## <<PlainTextDocument>>
    ## Metadata:  7
    ## Content:  chars: 5455
    ## 
    ## [[8]]
    ## <<PlainTextDocument>>
    ## Metadata:  7
    ## Content:  chars: 1573
    ## 
    ## [[9]]
    ## <<PlainTextDocument>>
    ## Metadata:  7
    ## Content:  chars: 717130
    ## 
    ## [[10]]
    ## <<PlainTextDocument>>
    ## Metadata:  7
    ## Content:  chars: 2681

File Transformations for better analysis

``` r
corpus_transform <- tm_map(corpus, content_transformer(stripWhitespace) ) #Removing Whitespace
corpus_transform <- tm_map(corpus_transform, content_transformer(tolower) ) #Comverting to lower text
corpus_transform <- tm_map(corpus_transform, content_transformer(removePunctuation) ) #RemovingPunctuation
corpus_transform <- tm_map(corpus_transform, removeWords, c(stopwords("english"), "target","market", "tmmapcorpustransform","corpustransform")) #Removing StopWords
corpus_transform <- tm_map(corpus_transform, content_transformer(stemDocument)) #Stemming the document
tweet_plot<- corpus_transform
```

Converting to term document matrix

``` r
tdm <- TermDocumentMatrix(corpus_transform)
inspect(tdm)
```

    ## <<TermDocumentMatrix (terms: 4990, documents: 10)>>
    ## Non-/sparse entries: 8375/41525
    ## Sparsity           : 83%
    ## Maximal term length: 442260
    ## Weighting          : term frequency (tf)
    ## Sample             :
    ##          Docs
    ## Terms     negative.txt positive.txt TargetedMark.md TargetedMark.Rmd
    ##   age                0            0               4                0
    ##   compani            0            0               6                0
    ##   market             0            0               0                0
    ##   negat              5            5               4                0
    ##   packag             0            0               9                0
    ##   pre                0            0               6                0
    ##   precod             0            0               6                0
    ##   script             0            0               6                0
    ##   segment            0            0               6                0
    ##   sentenc            0            0               0                0
    ##          Docs
    ## Terms     TargetedMark_Rfile.R TargetedMark1.txt TargetedMark2.txt
    ##   age                        0                11                 4
    ##   compani                    0                16                 1
    ##   market                     0                24                14
    ##   negat                      0                 0                 0
    ##   packag                     0                 0                 1
    ##   pre                        0                 0                 0
    ##   precod                     0                 0                 0
    ##   script                     0                 0                 0
    ##   segment                    0                 3                13
    ##   sentenc                    0                 0                 0
    ##          Docs
    ## Terms     Tweet_analysis.R Tweet101.html Tweet101.Rmd
    ##   age                    0             0            0
    ##   compani                0             1            0
    ##   market                 0             0            0
    ##   negat                  3             2            3
    ##   packag                 0            11            1
    ##   pre                    0            13            0
    ##   precod                 0            16            0
    ##   script                 0            15            0
    ##   segment                0             0            0
    ##   sentenc                0             9            9

Conversions to create a wordcloud

``` r
m <- as.matrix(tdm)
v <- sort(rowSums(m), decreasing=TRUE)
d <- data.frame(word=names(v), freq=v, stringsAsFactors=FALSE)
head(d)
```

    ##            word freq
    ## market   market   38
    ## compani compani   24
    ## negat     negat   22
    ## packag   packag   22
    ## precod   precod   22
    ## segment segment   22

Final Wordcloud

``` r
pal <- brewer.pal(8,"Dark2")
wordcloud(tweet_plot,  random.order = F, max.words = 50, scale = c(3,0.5), colors = pal)
```

![](TargetedMark_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png)
