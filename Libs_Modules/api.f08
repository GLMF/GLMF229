module api
  interface
    function usleep(usec) bind(c)
      use, intrinsic :: iso_c_binding, only: c_int
      integer(kind=c_int) usleep
      integer(kind=c_int), value, intent(in) :: usec
    end function usleep    
    subroutine tlx_c(n, string) bind(c)
      use, intrinsic :: iso_c_binding, only: c_char, c_size_t
      character(kind=c_char), intent(in) :: string(*)
      integer(kind=c_size_t), value, intent(in) :: n      
    end subroutine tlx_c
  end interface
end module api
