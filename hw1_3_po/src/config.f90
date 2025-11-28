module Config
   use Environment

   implicit none

   integer, parameter                   :: FILE_SURNAME_LEN = 15
   integer, parameter                   :: FILE_INITIALS_LEN = 5
   
   integer, parameter                   :: SURNAME_LEN = 16
   integer, parameter                   :: INITIALS_LEN = 8

   character(*), parameter              :: S_FORMAT = '(2(a, 1x), i4)'
   
   character(*), parameter              :: IN_FILE  = '../data/class.txt'
   character(*), parameter              :: OUT_FILE = 'output.txt'
   character(*), parameter              :: DAT_FILE = 'class.dat'

   type student
      character(SURNAME_LEN,  kind=CH_) :: Surname = ""
      character(INITIALS_LEN, kind=CH_) :: Initials = ""
      integer(I_)                       :: Year = 0
   end type student

   type student_na
      character(FILE_SURNAME_LEN,  kind=CH_) :: Surname = ""
      character(FILE_INITIALS_LEN, kind=CH_) :: Initials = ""
      integer(I_)                            :: Year = 0
   end type student_na
   
   integer, parameter                   :: RECL = & 
                                           (SURNAME_LEN + INITIALS_LEN)*CH_ + I_

end module Config
