module Process

   use Environment
   use Config

   implicit none

contains
   
   function find_first_by_alphabet(Surnames, Initials) result(first_ind)

      character(kind=CH_), intent(in) :: Surnames(:,:)
      character(kind=CH_), intent(in) :: Initials(:,:)
      integer                         :: first_ind
   
      integer                         :: row, comp
      
      first_ind = 1
         
      do row = 2, size(Surnames, dim=1)
         comp = compare_names(Surnames(first_ind, :), Surnames(row, :)) 
         if (comp == 1) then
           first_ind = row
         elseif (comp == 0) then
            comp = compare_names(Initials(first_ind, :), Initials(row, :))
            if(comp == 1) then
               first_ind = row
            endif
         endif
      end do

   contains
      
      function compare_names(First_Name, Second_Name) result(compare)
         
         character(kind=CH_), intent(in)           :: First_Name(:), Second_Name(:)
         integer                                   :: compare
         
         integer                                   :: first_diff
         logical, allocatable                      :: Comp_Mask(:)
   
         Comp_Mask = (First_Name /= Second_Name)
         first_diff = FindLoc(Comp_Mask, .true., dim=1)
         
         compare = 2

         if (first_diff == 0) then
            compare = 0
         else
            if (First_Name(first_diff) > Second_Name(first_diff)) then
               compare = 1
            endif
         endif
   
      end function compare_names 

   end function find_first_by_alphabet   
      
   function find_younger(Year) result(younger_ind)

      integer, intent(in) :: Year(:)
      integer             :: younger_ind

      integer             :: i
      
      younger_ind = 1

      do i = 2, size(Year)
         if (Year(i) < Year(younger_ind)) then
            younger_ind = i
         endif
      end do

   end function find_younger

end module Process   
