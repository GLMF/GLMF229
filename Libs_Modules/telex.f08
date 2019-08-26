module telex
  interface
    module recursive subroutine videotypef2f(string)
      character(len=*), intent(in) :: string
    end subroutine videotypef2f
  end interface
contains
  subroutine videotypec2f(n, string)
    use, intrinsic :: iso_c_binding, only: c_char, c_size_t
    character(kind=c_char), intent(in) :: string(*)
    integer(kind=c_size_t), value, intent(in) :: n
    character(len=:), allocatable :: chain
    !
    allocate(character(len=n) :: chain)
    write(chain,*) string(1:n-1)
    call videotypef2f(chain(2:n))
  end subroutine videotypec2f
end module telex
