module Process

   use Environment
   use Config

   implicit none

contains

   function find_first_by_alphabet(Surnames, Initials) result(first_ind)
      
      character(SURNAME_LEN, kind=CH_),  intent(in) :: Surnames(:)
      character(INITIALS_LEN, kind=CH_), intent(in) :: Initials(:)
      integer                                       :: first_ind
   
      integer                                       :: i

      first_ind = 1

      do i = 2, size(Surnames)
         if (Surnames(i) < Surnames(first_ind)) then
           first_ind = i
         else if (Surnames(i) == Surnames(first_ind)) then
            if (Initials(i) < Initials(first_ind)) then
               first_ind = i
            endif
         endif
      end do
       
   end function find_first_by_alphabet

   function find_younger(Year) result(younger_ind)

      integer, intent(in), allocatable :: Year(:)
      integer                          :: younger_ind

      integer                          :: i
      
      younger_ind = 1
      
      do i = 2, size(Year)
         if (Year(i) < Year(younger_ind)) then
            younger_ind = i
         end if
      end do
   
   end function find_younger

end module Process   
