module Process

   use Environment
   use Config

   implicit none

contains

   function find_first_by_alphabet(Group) result(first_ind)
   
      type(grp), intent(in) :: Group
      integer               :: first_ind

      first_ind = find_min_alpha(Group, 2, 1)

   contains

      pure recursive function find_min_alpha(Group, cInd, mInd) result(first_by_alph)

         type(grp), intent(in)    :: Group
         integer,   intent(in)    :: cInd, mInd
         integer                  :: first_by_alph

         if(cInd < (size(Group%Surname) + 1)) then
            if(Group%Surname(mInd) > Group%Surname(cInd)) then
               first_by_alph = find_min_alpha(Group, cInd+1, cInd)
            else if(Group%Surname(mInd) == Group%Surname(cInd)) then
               if (Group%Initials(mInd) > Group%Initials(cInd)) then
                  first_by_alph = find_min_alpha(Group, cInd+1, cInd)
               else
                  first_by_alph = find_min_alpha(Group, cInd+1, mInd)
               endif
            else
               first_by_alph = find_min_alpha(Group, cInd+1, mInd)
            endif
         else 
            first_by_alph = mInd
         endif
        
      end function find_min_alpha
    
   end function find_first_by_alphabet

   function find_younger(Group) result(younger_ind)

      type(grp), intent(in) :: Group
      integer               :: younger_ind

      younger_ind = get_year(Group, 2, 1)
         
   contains
      
      pure recursive function get_year(Group, cInd, mInd) result(younger)
      
         type(grp), intent(in)    :: Group
         integer,   intent(in)    :: cInd, mInd
         integer                  :: younger

         if(cInd < (size(Group%Year) + 1)) then
            if(Group%Year(mInd) > Group%Year(cInd)) then
               younger = get_year(Group, cInd+1, cInd)
            else
               younger = get_year(Group, cInd+1, mInd)
            endif
         else
            younger = mInd
         endif
         
      end function get_year
      
   end function find_younger

end module Process   
