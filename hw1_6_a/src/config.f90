module Config
   use Environment

   implicit none

   integer, parameter                   :: SURNAME_LEN = 15
   integer, parameter                   :: INITIALS_LEN = 5

   character(*), parameter              :: S_FORMAT = '(2(a, 1x), i4)'
   
   character(*), parameter              :: IN_FILE  = '../data/class2.txt'
   character(*), parameter              :: OUT_FILE = 'output.txt'
   character(*), parameter              :: DAT_FILE = 'class.dat'

   character(*), parameter              :: READ_OUT_FILE = 'r_read.txt'
   character(*), parameter              :: SUR_OUT_FILE = 'r_sur.txt'
   character(*), parameter              :: YEAR_OUT_FILE = 'r_year.txt'
   
   type student
      character(SURNAME_LEN,  kind=CH_) :: Surname = ""
      character(INITIALS_LEN, kind=CH_) :: Initial = ""
      integer(I_)                       :: Year = 0
      type(student), pointer            :: next => Null()
   end type student

   integer, parameter                   :: RECL = & 
                                           (SURNAME_LEN + INITIALS_LEN)*CH_ + I_

end module Config
