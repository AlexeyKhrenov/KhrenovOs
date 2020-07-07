void main(){
    char* video_memory_ptr = (char*) 0xb8000;
    *video_memory_ptr = 'X';
}