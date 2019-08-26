module telex_m
  interface
    function usleep(usec) bind(c)
      use, intrinsic :: iso_c_binding, only: c_int
      integer(kind=c_int) usleep
      integer(kind=c_int), value, intent(in) :: usec
    end function usleep    
  end interface
  integer, private :: i=1
contains
  recursive subroutine tlx(string)
    use, intrinsic :: iso_c_binding, only: c_int
    use ECMA48, only: sgr_t
    character(len=*), intent(in) :: string
    integer(kind=c_int), parameter :: USECS = 110000
    type(sgr_t) :: s
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
    s = sgr_t(sentence=string(i:i+j), color='BROWN')
    write(*,fmt='(DT)', advance='no') s
    deallocate(s%sentence)
    if (usleep(USECS) == -1) error stop
    i = i+1+j
    call tlx(string)
  end subroutine tlx
end module telex_m
