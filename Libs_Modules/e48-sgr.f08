module ECMA48
  enum, bind(c)
    enumerator :: reset, bold, black=30, red, green, brown, blue, magenta, cyan, white 
  end enum
  type sgr_t
    character(len=:), allocatable :: sentence
    character(len=7) :: color =''
  contains
    procedure, private :: E48_SGR
    generic :: write(formatted) => E48_SGR
  end type sgr_t
contains
!
subroutine E48_SGR(dtv, unit, iotype, v_list, iostat, iomsg)    
  class(sgr_t), intent(in) :: dtv  
  integer, intent(in) :: unit    
  character(len=*), intent(in) :: iotype    
  integer, intent(in) :: v_list(:)    
  integer, intent(out) :: iostat    
  character(len=*), intent(inout) :: iomsg  
  character(len=*), parameter :: ESC = achar(27) // "["  
  integer :: color  
  !  
  select case (dtv%color)    
    case ('BROWN') ; color = brown  
    case ('GREEN') ; color = green  
    ! (...)  
    case default ; error stop ": couleur inconnue."    
  end select  
  write(unit,fmt='(a,i0,a,i0,3a,i0,a)')ESC,bold,";",color,"m",dtv%sentence,ESC,reset,"m"      
end subroutine E48_SGR  
!
end module ECMA48
