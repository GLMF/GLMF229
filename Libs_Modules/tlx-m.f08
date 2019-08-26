module tlx_m
  interface
    module recursive subroutine tlx_f(string)
      character(len=*), intent(in) :: string
    end subroutine tlx_f
  end interface
contains
  subroutine tlx_c(n, string)
    use, intrinsic :: iso_c_binding, only: c_char, c_size_t
    character(kind=c_char), intent(in) :: string(*)
    integer(kind=c_size_t), value, intent(in) :: n
    character(len=:), allocatable :: s
    !
    allocate(character(len=n) :: s)
    write(s,*) string(1:n-1)
    call tlx_f(s(2:n))
  end subroutine tlx_c
end module tlx_m
