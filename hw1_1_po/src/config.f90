module Config
   use Environment

   implicit none

   integer, parameter                             :: FILE_SURNAME_LEN = 15
   integer, parameter                             :: FILE_INITIALS_LEN = 5
   
   integer, parameter                             :: SURNAME_LEN = 16
   integer, parameter                             :: INITIALS_LEN = 8

   character(*), parameter :: S_FORMAT = '(a15, 1x, a5, 1x, i4)'
   character(*), parameter :: IN_FILE  = '../data/class.txt'
   character(*), parameter :: OUT_FILE = 'output.txt'

end module Config
