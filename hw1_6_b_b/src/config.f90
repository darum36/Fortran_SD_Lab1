module Config
   use Environment

   implicit none

   integer, parameter                   :: SURNAME_LEN = 15
   integer, parameter                   :: INITIALS_LEN = 5

   character(*), parameter              :: S_FORMAT = '(2(a, 1x), i4)'
   
   character(*), parameter              :: IN_FILE  = '../data/class.txt'
   character(*), parameter              :: OUT_FILE = 'output.txt'
   character(*), parameter              :: DAT_FILE = 'class.dat'

   type student
      character(SURNAME_LEN,  kind=CH_) :: Surname = ""
      character(INITIALS_LEN, kind=CH_) :: Initial = ""
      integer(I_)                       :: Year = 0
      type(student), allocatable        :: next
   end type student

end module Config
