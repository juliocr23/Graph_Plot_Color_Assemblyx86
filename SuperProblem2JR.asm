COMMENT*
		Julio Rosario 4/4/17

		          2. Color box
•	Pick 1000 random pairs of  dl and dhs   (dl>=3 and dl<=25)   (dh>=5 and dh<=15)
•	Plot these point in random colors 1-15    
•	Count  the colors and on a  cleared screen print them with a delay  of 4000 after the box is finished

   That is to say:
                  < loop 1000 times with random x from [3,25] and random y [5,15]
			   < plot the x and y in random colors [1,15]
			   < use an empty array to store what was displayed 
			   < clear the screen and display array with delay of 4 seconds.
*COMMENT

include irvine32.inc
x textequ<DL>
y textequ<DH>

.data
xcoords byte 1000 DUP(0)
ycoords byte 1000 DUP(0)
colors byte 1000 DUP(0)

.code
main PROC
	
	call Randomize
	call fillScreen	;Plot points with random colors
	MOV EAX,1000
	call delay

	call Clrscr      ;clear screen
	call displayColors ;Display counted colors.

	MOV x,0
	MOV y,20

	call gotoXY
	call crlf
exit
main endp

fillScreen PROC USES ECX EAX
	
	MOV EDX,0
	MOV EAX,0
	MOV ECX,1000
	MOV ESI,0

	L1:
		call getRandomX
		call getRandomY
		call getRandomColor
			
		MOV colors[ESI],AL
		MOV xcoords[ESI],x
		MOV ycoords[ESI],y

		call displayColoredPoints
		INC ESI
	LOOP L1

	MOV x,0
	MOV y,20

	call gotoXY
	call crlf
ret
fillScreen ENDP

getRandomX PROC
		
	MOV AL,23			 ;From 0 to 22
	call RandomRange     ;generate random int
	add AL,3             ;Values from 3 to 25

	MOV x,AL			;Save x coordinate
ret
getRandomX ENDP

getRandomY PROC
		
	MOV AL,11           ;From 0-10
	call RandomRange   ;generate random int
	add AL,5           ;from 5-15

	MOV y,AL          ;Save y coordinate
ret
getRandomY ENDP

getRandomColor PROC 

	MOV AL,15  	   ;From 0-14
	inc AL           ; from 1-15
	call RandomRange  ;generate random int
	call setTextColor ;create color for text

ret
getRandomColor ENDP
displayColoredPoints PROC

		call gotoXY       ;Goto location

		MOV AL,"*"
		call writechar
ret
displayColoredPoints ENDP

displayColors PROC

MOV ESI,0
MOV ECX,1000
MOV EAX,4000
L1:
	MOV x, xcoords[ESI]
	MOV y, ycoords[ESI]
	call gotoXY

	MOV AL,colors[ESI]
	call setTextColor
	
	MOV AL,"*"
	call writechar
	call delay

	INC ESI
LOOP L1

ret
displayColors ENDP
end main 