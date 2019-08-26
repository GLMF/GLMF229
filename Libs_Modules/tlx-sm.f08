submodule(tlx_m) tlx_sm
  integer :: i=1
contains
  recursive subroutine tlx_f(string)
    use, intrinsic :: iso_c_binding, only: c_int
    character(len=*), intent(in) :: string
    interface
      function usleep(usec) bind(c)
        use, intrinsic :: iso_c_binding, only: c_int
        integer(kind=c_int) usleep
        integer(kind=c_int), value, intent(in) :: usec
      end function usleep    
    end interface
    integer(kind=c_int), parameter :: USECS = 110000
    character(len=*), parameter :: GREEN = achar(27) // "[1;32m"
    character(len=*), parameter :: RESET = achar(27) // "[0m"
    integer j
    character(len=1) c
    !
    if (i > len(string)) then
      i = 1; return
    end if
    c = string(i:i)
    if (ichar(c) < Z'7F') j = 0
    if (ichar(c) >= Z'C2' .and. ichar(c) <= Z'DF') j = 1
    if (ichar(c) >= Z'E0' .and. ichar(c) <= Z'EF') j = 2
    if (ichar(c) >= Z'F0') j = 3
    write(*,'(3a)', advance='no') GREEN, string(i:i+j), RESET
    if (usleep(USECS) == -1) error stop
    i = i+1+j
    call tlx_f(string)
  end subroutine tlx_f
end submodule tlx_sm
