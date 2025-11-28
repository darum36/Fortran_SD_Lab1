module Config
   use Environment

   implicit none

   integer, parameter                             :: SURNAME_LEN = 16
   integer, parameter                             :: INITIALS_LEN = 8

   integer, parameter                             :: FILE_SURNAME_LEN = 15
   integer, parameter                             :: FILE_INITIALS_LEN = 5
  

   character(*), parameter :: S_FORMAT = '(15a1, 1x, 5a1, 1x, i4)'
   character(*), parameter :: IN_FILE  = '../../class.txt'
   character(*), parameter :: OUT_FILE = 'output.txt'

end module Config
