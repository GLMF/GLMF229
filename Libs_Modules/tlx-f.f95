subroutine tlx_f(string)
  implicit none
  integer :: i=1
  character(len=*), intent(in) :: string
  call tlx(string)
contains
  include 'tlx.f08'
end subroutine tlx_f
