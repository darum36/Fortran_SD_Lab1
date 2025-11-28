module Config
   use Environment

   implicit none

   integer, parameter                   :: SURNAME_LEN = 16
   integer, parameter                   :: INITIALS_LEN = 8

   integer, parameter                   :: FILE_SURNAME_LEN = 15
   integer, parameter                   :: FILE_INITIALS_LEN = 5
   
   character(*), parameter              :: S_FORMAT = '(2(a, 1x), i4)'
   
   character(*), parameter              :: IN_FILE  = '../data/class.txt'
   character(*), parameter              :: OUT_FILE = 'output.txt'
   character(*), parameter              :: DAT_FILE = 'class.dat'

   type student_na
      character(FILE_SURNAME_LEN,  kind=CH_) :: Surname
      character(FILE_INITIALS_LEN, kind=CH_) :: Initials
      integer(I_)                            :: Year
   end type student_na
   
   type grp
      character(SURNAME_LEN,  kind=CH_), allocatable :: Surname(:)
      character(INITIALS_LEN, kind=CH_), allocatable :: Initials(:)
      integer(I_)                      , allocatable :: Year(:)
   end type grp

   integer, parameter                   :: RECL = & 
                                           (SURNAME_LEN + INITIALS_LEN)*CH_ + I_

end module Config
