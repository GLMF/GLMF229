subroutine tlx_c(n, string)
  use, intrinsic :: iso_c_binding, only: c_char, c_size_t
  implicit none
  character(kind=c_char), intent(in) :: string(*)
  integer(kind=c_size_t), value, intent(in) :: n
  integer :: i=1
  character(len=:), allocatable :: s
  !
  allocate(character(len=n) :: s)
  write(s,*) string(1:n-1)
  call tlx(s(2:n))
contains
  include 'tlx.f08' 
end subroutine tlx_c
