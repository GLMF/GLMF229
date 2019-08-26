program telex
  use, intrinsic :: iso_fortran_env, only: iostat_end
  implicit none
  integer :: i=1, ios=0
  character(len=4096) buffer
  character(len=:), allocatable :: string
  !
  allocate(string, source="")
  do while (ios /= iostat_end)
    buffer = ""
    read(unit=*, fmt='(a)', iostat=ios) buffer
    if (ios == iostat_end) then
      string = string // trim(buffer)
    else
      string = string // trim(buffer) // new_line('a')
    end if
  end do
  call tlx(string)
  deallocate(string)
contains
  include "tlx.f08"
end program telex

