module Config
   use Environment

   implicit none

   integer, parameter                   :: SURNAME_LEN = 15
   integer, parameter                   :: INITIALS_LEN = 5
   
   character(*), parameter              :: S_FORMAT = '(2(a, 1x), i4)'
   
   character(*), parameter              :: IN_FILE  = '../../class.txt'
   character(*), parameter              :: OUT_FILE = 'output.txt'
   character(*), parameter              :: DAT_FILE = 'class.dat'

   type grp
      character(SURNAME_LEN,  kind=CH_), allocatable :: Surname(:)
      character(INITIALS_LEN, kind=CH_), allocatable :: Initials(:)
      integer(I_)                      , allocatable :: Year(:)
   end type grp

end module Config
