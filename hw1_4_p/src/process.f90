module Process

   use Environment
   use Config

   implicit none

contains

   function find_first_by_alphabet(Group) result(first_ind)
   
      type(grp), intent(in) :: Group
      integer               :: first_ind

      integer               :: i

      first_ind = 1
         
      do i = 2, size(Group%Surname)
         if (Group%Surname(i) < Group%Surname(first_ind)) then
            first_ind = i
         else if (Group%Surname(i) == Group%Surname(first_ind)) then
            if (Group%Initials(i) < Group%Initials(first_ind)) then
               first_ind = i
            end if
         end if
      end do

   end function find_first_by_alphabet   

   function find_younger(Group) result(younger_ind)

      type(grp), intent(in) :: Group
      integer               :: younger_ind

      integer               :: i

      younger_ind = 1
         
      do i = 2, Size(Group%Year)
         if (Group%Year(i) < Group%Year(younger_ind)) then
            younger_ind = i
         end if
      end do

   end function find_younger

end module Process   
