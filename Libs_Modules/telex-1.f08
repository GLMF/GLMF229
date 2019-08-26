program telex
  use, intrinsic :: iso_c_binding, only: c_int
  implicit none
  interface
    function usleep(usec) bind(c)
      import c_int
      integer(kind=c_int) usleep
      integer(kind=c_int), value, intent(in) :: usec
    end function usleep
  end interface
  integer i
  integer(kind=c_int), parameter :: USECS = 110000
  character(len=*), parameter :: GREEN = achar(27) // "[1;32m"
  character(len=*), parameter :: RESET = achar(27) // "[0m"
  character(len=4096) buffer
  !
  read(unit=*, fmt='(a)') buffer
  do i=1, len_trim(buffer)
    write(unit=*, fmt='(3a)', advance='no') GREEN, buffer(i:i), RESET
    if (usleep(USECS) == -1) error stop
  end do
  print*
end program telex
