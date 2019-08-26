recursive subroutine tlx(string)
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
  ! Le 1er octet dit le nb d'octets en codage UTF-8
  if (ichar(c) < Z'7F') j = 0 ! Lettre codée sur 1 octet
  if (ichar(c) >= Z'C2' .and. ichar(c) <= Z'DF') j = 1
  if (ichar(c) >= Z'E0' .and. ichar(c) <= Z'EF') j = 2
  if (ichar(c) >= Z'F0') j = 3 ! Lettre codée sur 4 octets
  ! Affichage en vert de la lettre puis attente de 110 msec
  write(unit=*, fmt='(3a)', advance='no') GREEN, string(i:i+j), RESET
  if (usleep(USECS) == -1) error stop
  i = i+1+j
  call tlx(string)
end subroutine tlx
