SECTION .text

global Sleep
global Event
global GetButtonID
global CreateButton
global Exit
global Redraw
global DrawWindow
global WriteText
global GetTime
global DrawLine
global DrawBar
global DebugOutHex
global DebugOutChar
global DebugOutStr
global WriteText2

SECTION .text

Sleep:
    push ebp
    mov ebp, esp
    mov eax, 5            ; ID вызова
    mov ebx, [ebp+8]      ; Параметр (например, время задержки)
    int 0x40              ; Системный вызов (пример для Linux/x86)
    mov esp, ebp
    pop ebp
    ret

Event:
    mov eax, 10           ; ID вызова
    int 0x40              ; Системный вызов
    ret

GetButtonID:
  mov   eax,17
  int   0x40
  test  al,al
  jnz   .no_button
  shr   eax,8
  ret
.no_button:
  xor   eax,eax
  dec   eax
  ret

Exit:
	mov eax, -1
	int 0x40
    ret

Redraw:
	push ebp
    mov ebp,esp
	mov eax, 12
	mov ebx, [ebp+8]
	int 0x40
	mov esp,ebp
    pop ebp
    ret

DrawWindow:
	push ebp
    mov ebp,esp
	xor eax, eax
    mov ebx, [ebp+8]       ; первый аргумент
    shl ebx, 16
    or ebx, [ebp+12]        ; второй аргумент
    mov ecx, [ebp+16]      ; третий аргумент
    shl ecx, 16
    or ecx, [ebp+20]       ; четвертый аргумент
    mov edx, 0x33FFFFFF
	mov edi, [ebp+24]      ; пятый аргумент
    mov esi, 0
    int 0x40
	mov esp,ebp
    pop ebp
    ret

WriteText:
    push ebp
    mov ebp,esp
    mov eax,4
    mov ebx,[ebp+8]
    shl ebx,16
    mov bx,[ebp+12]
    mov ecx,[ebp+16]
    mov edx,[ebp+20]
    mov esi,[ebp+24]
    int 0x40
    mov esp,ebp
    pop ebp
    ret

WriteText2:
    push ebp
    mov ebp,esp
    mov eax,47
    mov ebx,[ebp+8]
    shl ebx,16
    mov ecx,[ebp+12]
    mov edx,[ebp+20]
    shl edx,16
    add edx, [ebp+24]
    mov esi,[ebp+28]
    int 0x40
    mov esp,ebp
    pop ebp
    ret

DrawLine:
    push ebp
    mov ebp,esp
    mov ebx,[ebp+8]
    shl ebx,16
    mov bx,[ebp+16]
    mov ecx,[ebp+12]
    shl ecx,16
    mov cx,[ebp+20]
    mov edx,[ebp+24]
    mov eax,38
    int 0x40
    mov esp,ebp
    pop ebp
    ret

DrawBar:
    push ebp
    mov ebp,esp
    mov   eax,13
    mov   ebx,[ebp+8]
    shl   ebx,16
    mov   bx,[ebp+16]
    mov   ecx,[ebp+12]
    shl   ecx,16
    mov   cx,[ebp+20]
    mov   edx,[ebp+24]
    int   0x40
    mov esp,ebp
    pop ebp
    ret

GetTime:
    mov eax, 3
    int 0x40
    ret

DebugOutHex:
    mov eax, [esp+4]
    mov   edx, 8
    .new_char:
    rol   eax, 4
    movzx ecx, al
    and   cl,  0x0f
    mov   cl,  [__hexdigits + ecx]
    pushad
    mov eax, 63
    mov ebx, 1
    int 0x40
    popad
    dec   edx
    jnz   .new_char
    ret

DebugOutChar:
   mov al, [esp+4]
   pushf
   pushad
   mov  cl,al
   mov  eax,63
   mov  ebx,1
   int  0x40
   popad
   popf
   ret

DebugOutStr:
   mov  edx,[esp+4]
   mov  eax,63
   mov  ebx,1
 m2:
   mov  cl, [edx]
   test cl,cl
   jz   m1
   int  40h
   inc  edx
   jmp  m2
 m1:
   ret

CreateButton:
  push  ebp
  mov   ebp,esp
  mov   eax, 8
  mov ebx, [ebp+8]
  shl ebx, 16
  mov bx, [ebp+16]
  mov ecx, [ebp+12]
  shl ecx, 16
  mov cx, [ebp+20]
  mov edx, [ebp+24]
  mov esi, [ebp+28]
  int   0x40
  mov   esp,ebp
  pop   ebp
  ret

global malloc
global free
global realloc

malloc:
    ; Номер системного вызова mmap (90)
    mov eax, 68       ; mmap
    mov ebx, 12        ; адрес (NULL)
    mov ecx, [esp+4]  ; размер памяти (параметр, переданный через стек)
    int 0x40          ; вызов системного вызова
    ret
	
free:
    ; Номер системного вызова mmap (90)
    mov eax, 68       ; mmap
    mov ebx, 13        ; адрес (NULL)
    mov ecx, [esp+4]  ; размер памяти (параметр, переданный через стек)
    int 0x40          ; вызов системного вызова
    ret
	
realloc:
    ; Номер системного вызова mmap (90)
    mov eax, 68       ; mmap
    mov ebx, 13        ; адрес (NULL)
    mov edx, [esp+4] ; указатель на старую память
	mov ecx, [esp+8] ; новый размер памяти
    int 0x40          ; вызов системного вызова
    ret

; Описание данных
SECTION .data
__hexdigits:
    db '0123456789ABCDEF' ; Символы для отображения в шестнадцатеричном формате

; Пример использования данных
__test:
    dd __hexdigits        ; Пример ссылки на данные
    dd 15                 ; Пример значения
