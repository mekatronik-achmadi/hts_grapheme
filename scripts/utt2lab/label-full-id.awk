#  ---------------------------------------------------------------  #
#           The HMM-Based Speech Synthesis System (HTS)             #
#                       HTS Working Group                           #
#                                                                   #
#                  Department of Computer Science                   #
#                  Nagoya Institute of Technology                   #
#                               and                                 #
#   Interdisciplinary Graduate School of Science and Engineering    #
#                  Tokyo Institute of Technology                    #
#                                                                   #
#                     Copyright (c) 2001-2007                       #
#                       All Rights Reserved.                        #
#                                                                   #
#  Permission is hereby granted, free of charge, to use and         #
#  distribute this software and its documentation without           #
#  restriction, including without limitation the rights to use,     #
#  copy, modify, merge, publish, distribute, sublicense, and/or     #
#  sell copies of this work, and to permit persons to whom this     #
#  work is furnished to do so, subject to the following conditions: #
#                                                                   #
#    1. The source code must retain the above copyright notice,     #
#       this list of conditions and the following disclaimer.       #
#                                                                   #
#    2. Any modifications to the source code must be clearly        #
#       marked as such.                                             #
#                                                                   #
#    3. Redistributions in binary form must reproduce the above     #
#       copyright notice, this list of conditions and the           #
#       following disclaimer in the documentation and/or other      #
#       materials provided with the distribution.  Otherwise, one   #
#       must contact the HTS working group.                         #
#                                                                   #
#  NAGOYA INSTITUTE OF TECHNOLOGY, TOKYO INSTITUTE OF TECHNOLOGY,   #
#  HTS WORKING GROUP, AND THE CONTRIBUTORS TO THIS WORK DISCLAIM    #
#  ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL       #
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT   #
#  SHALL NAGOYA INSTITUTE OF TECHNOLOGY, TOKYO INSTITUTE OF         #
#  TECHNOLOGY, HTS WORKING GROUP, NOR THE CONTRIBUTORS BE LIABLE    #
#  FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY        #
#  DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,  #
#  WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTUOUS   #
#  ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR          #
#  PERFORMANCE OF THIS SOFTWARE.                                    #
#                                                                   #
#  ---------------------------------------------------------------  #

{
##############################
###  SEGMENT

#  boundary
   printf "%10.0f %10.0f ", 1e7 * $65, 1e7 * $66

#  pp.name
    printf "%s",  $63 == "0" ? "x" : $63
#  p.name
    printf "^%s", $1  == "0" ? "x" : $1
#  c.name
    printf "-%s", $2
#  n.name
    printf "+%s", $3  == "0" ? "x" : $3
#  nn.name
    printf "=%s", $64 == "0" ? "x" : $64 

#  position in syllable (segment)
    printf "@"
    printf "%s",  $2 == "SIL" ? "x" : $4 + 1
    printf "_%s", $2 == "SIL" ? "x" : $12 - $4

##############################
###  SYLLABLE

## previous syllable

#  p.stress
    printf "/A:%s", $2 == "SIL" ? $49 : $5
#  p.accent
    printf "_%s", $2 == "SIL" ? $51 : $8
#  p.length
    printf "_%s", $2 == "SIL" ? $53 : $11

## current syllable

#  c.stress
    printf "/B:%s", $2 == "SIL" ? "x" : $6
#  c.accent
    printf "-%s", $2 == "SIL" ? "x" : $9
#  c.length
    printf "-%s", $2 == "SIL" ? "x" : $12

#  position in word (syllable)
    printf "@%s", $2 == "SIL" ? "x" : $14 + 1
    printf "-%s", $2 == "SIL" ? "x" : $30 - $14

#  position in phrase (syllable)
    printf "&%s", $2 == "SIL" ? "x" : $15 + 1
    printf "-%s", $2 == "SIL" ? "x" : $16 + 1

#  position in phrase (stressed syllable)
    printf "#%s", $2 == "SIL" ? "x" : $17 + 1
    printf "-%s", $2 == "SIL" ? "x" : $18 + 1

#  position in phrase (accented syllable)
    printf  "$"
    printf "%s", $2 == "SIL" ? "x" : $19 + 1
    printf "-%s", $2 == "SIL" ? "x" : $20 + 1

#  distance from stressed syllable
    printf "!%s", $2 == "SIL" ? "x" : $21
    printf "-%s", $2 == "SIL" ? "x" : $22

#  distance from accented syllable 
    printf ";%s", $2 == "SIL" ? "x" : $23
    printf "-%s", $2 == "SIL" ? "x" : $24

#  name of the vowel of current syllable
    printf "|%s", $2 == "SIL" ? "x" : $25

## next syllable

#  n.stress
    printf "/C:%s", $2 == "SIL" ? $50 : $7
#  n.accent
    printf "+%s", $2 == "SIL" ? $52 : $10
#  n.length
    printf "+%s", $2 == "SIL" ? $54 : $13

##############################
#  WORD

##################
## previous word

#  p.gpos
    printf "/D:%s", $2 == "SIL" ? $55 : $26
#  p.lenght (syllable)
    printf "_%s", $2 == "SIL" ? $57 : $29

#################
## current word

#  c.gpos
    printf "/E:%s", $2 == "SIL" ? "x" : $27
#  c.lenght (syllable)
    printf "+%s", $2 == "SIL" ? "x" : $30

#  position in phrase (word)
    printf "@%s", $2 == "SIL" ? "x" : $32 + 1
    printf "+%s", $2 == "SIL" ? "x" : $33

#  position in phrase (content word)
    printf "&%s", $2 == "SIL" ? "x" : $34 + 1
    printf "+%s", $2 == "SIL" ? "x" : $35

#  distance from content word in phrase
    printf "#%s", $2 == "SIL" ? "x" : $36
    printf "+%s", $2 == "SIL" ? "x" : $37

##############
## next word

#  n.gpos
    printf "/F:%s", $2 == "SIL" ? $56 : $28
#  n.lenghte (syllable)
    printf "_%s", $2 == "SIL" ? $58 : $31

##############################
#  PHRASE

####################
## previous phrase

#  length of previous phrase (syllable)
    printf "/G:%s", $2 == "SIL" ? $59 : $38

#  length of previous phrase (word)
    printf "_%s"  , $2 == "SIL" ? $61 : $41

####################
## current phrase

#  length of current phrase (syllable)
    printf "/H:%s", $2 == "SIL" ? "x" : $39

#  length of current phrase (word)
    printf "=%s",   $2 == "SIL" ? "x" : $42

#  position in major phrase (phrase)
    printf "@";
    printf "%s", $44 + 1
    printf "=%s", $48 - $44

#  type of tobi endtone of current phrase
    printf "|%s",  $45

####################
## next phrase

#  length of next phrase (syllable)
    printf "/I:%s", $2 == "SIL" ? $60 : $40

#  length of next phrase (word)
    printf "=%s",   $2 == "SIL" ? $62 : $43

##############################
#  UTTERANCE

#  length (syllable)
    printf "/J:%s", $46

#  length (word)
    printf "+%s", $47

#  length (phrase)
    printf "-%s", $48

    printf "\n"
}
