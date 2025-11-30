module Process

   use Environment
   use Config

   implicit none

contains

   function find_first_by_alphabet(Group) result(first_ind)
   
      type(student), intent(in) :: Group(:)
      integer                   :: first_ind

      integer                   :: i

      first_ind = 1

      do i = 2, Size(Group)
         if (Group(i)%Surname < Group(first_ind)%Surname) then
            first_ind = i
         else if (Group(i)%Surname == Group(first_ind)%Surname) then
            if (Group(i)%Initials < Group(first_ind)%Initials) then
               first_ind = i
            endif
         endif
      end do

   end function find_first_by_alphabet   

   function find_younger(Group) result(younger_ind)

      type(student), intent(in) :: Group(:)
      integer                   :: younger_ind

      integer                   :: i

      younger_ind = 1

      do i = 2, Size(Group)
         if (Group(i)%Year < Group(younger_ind)%Year) then
            younger_ind = i
         end if
      end do

   end function find_younger

end module Process   
