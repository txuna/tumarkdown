# tumarkdown grammar

this is  fun and cool and ..... new paradigm markdown grammar 

tumarkdown# Install

```
git clone https://github.com/kissesy/tumarkdown.git
sudo apt install flex 
sudo apt install yacc 
cd tumarkdown
flex lex.l 
yacc -d parse.y
gcc lex.yy.c y.tab.c -o mark
`````
## Usage

Currently, only the syntax of the file can be checked. 

`````
./mark test.md 
`````
Output  "Syntax OK" is your code is good 
Output "Syntax NG" is your code is sad ..ㅠㅠ 

## Grammar 

In my grammar there are several paragraphs under mddoc. 
And you can put content in each paragraph.

H1 is Header One
H2 is Header Two 

Currently only headers from Markdown are available.
I plan to make several grammar points later.
and I will make tumarkdown to html! 
`````
Paragraph->{
	H1->{"Hello WOrld"}
}
Paragraph->{
	H2->{"Hello WOrld"}
}
`````

## Please

My grammar is not really good. But I look forward to your pull request. We look forward to your participation

## Reference

I referenced streem language tag 201503````
