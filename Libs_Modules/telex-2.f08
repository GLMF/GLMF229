program telex
  use, intrinsic :: iso_c_binding, only: c_int
  use, intrinsic :: iso_fortran_env, only: iostat_end  
  implicit none
  interface
    function usleep(usec) bind(c)
      use, intrinsic :: iso_c_binding, only: c_int
      integer(kind=c_int) usleep
      integer(kind=c_int), value, intent(in) :: usec
    end function usleep
  end interface
  integer :: i, ios=0
  integer(kind=c_int), parameter :: USECS = 110000
  character(len=*), parameter :: GREEN = achar(27) // "[1;32m"
  character(len=*), parameter :: RESET = achar(27) // "[0m"
  character(len=4096) buffer
  character(len=:), allocatable :: chain  
  !
  allocate(chain, source="")
  do while (ios /= iostat_end)
    buffer = ""
    read(unit=*, fmt='(a)', iostat=ios) buffer
    if (ios == iostat_end) then
      chain = chain // trim(buffer)
    else
      chain = chain // trim(buffer) // new_line('a')
    end if  
  end do  
  do i=1, len_trim(chain)
    write(unit=*, fmt='(3a)', advance='no') GREEN, chain(i:i), RESET
    if (usleep(USECS) == -1) error stop
  end do
  deallocate(chain)
end program telex
