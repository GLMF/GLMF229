program telex
  use, intrinsic :: iso_fortran_env, only: iostat_end
  use tlx_m, only: tlx_f
  implicit none
  integer :: ios=0
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
  call tlx_f(string)
  deallocate(string)
end program telex
