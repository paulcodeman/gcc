extern void Sleep(uint32_t delay);
extern uint32_t GetTime(void);  // Возвращает время типа uint32
extern int Event(void);         // Возвращает int
extern int GetButtonID(void);   // Возвращает id типа int
extern void CreateButton(int x, int y, int xsize, int ysize, int id, uint32_t color);
extern void Exit(void);
extern void Redraw(int id);
extern void DrawWindow(int y, int x, int w, int h, const char* title);  // Заголовок как строка
extern void WriteText(int x, int y, uint32_t color, const char* text);  // Строка текста
extern void WriteText2(int x, int y, int z, uint32_t color1, uint32_t color2);
extern uint32_t DrawLine(int x1, int y1, int x2, int y2, uint32_t color);  // Возвращает uint32
extern void DrawBar(int x, int y, int xsize, int ysize, uint32_t color);
extern void DebugOutHex(uint32_t value);
extern void DebugOutChar(char byte);  // Параметр типа byte (char в C)
extern void DebugOutStr(const char* str);  // Строка

extern void* malloc(size_t size);
extern void free(void* ptr);
extern void* realloc(void* ptr, size_t new_size);

// Реализация функции strcpy
char* strcpy(char *dest, const char *src) {
    char *dest_start = dest;
    while (*src) {
        *dest++ = *src++;
    }
    *dest = '\0';
    return dest_start;  // Возвращаем указатель на начало строки
}

// Реализация функции strlen
size_t strlen(const char *str) {
    const char *s = str;
    while (*s) {
        s++;
    }
    return s - str;  // Возвращаем разницу указателей
}

int strcmp(const char *str1, const char *str2) {
    while (*str1 && (*str1 == *str2)) {
        str1++;
        str2++;
    }
    return *(unsigned char *)str1 - *(unsigned char *)str2;
}

char *strcat(char *dest, const char *src) {
    // Находим конец первой строки
    while (*dest) {
        dest++;  // Перемещаем указатель по первой строке
    }

    // Копируем вторую строку в конец первой
    while (*src) {
        *dest = *src;  // Копируем символ
        dest++;         // Переходим к следующей позиции в первой строке
        src++;          // Переходим к следующему символу во второй строке
    }

    *dest = '\0';  // Завершаем строку нулевым символом
    return dest;  // Возвращаем указатель на начало первой строки
}

void *memcpy(void *dest, const void *src, size_t n) {
    char *d = (char *)dest;
    const char *s = (const char *)src;
    while (n--) {
        *d++ = *s++;
    }
    return dest;
}

int memcmp(const void *s1, const void *s2, size_t n) {
    const unsigned char *p1 = (const unsigned char *)s1;
    const unsigned char *p2 = (const unsigned char *)s2;
    while (n--) {
        if (*p1 != *p2) {
            return *p1 - *p2;
        }
        p1++;
        p2++;
    }
    return 0;
}