module Process

   use Environment
   use Config

   implicit none

contains

   function find_first_by_alphabet(Group) result(first_ind)
   
      type(grp), intent(in) :: Group
      integer               :: first_ind

      integer               :: n = 1

      n = size(Group%Year)
      first_ind = n
      
      call find_min_alpha(Group, n-1, first_ind)

   contains

      pure recursive subroutine find_min_alpha(Group, cInd, mInd)

         type(grp), intent(in)    :: Group
         integer,   intent(in)    :: cInd

         integer,   intent(inout) :: mInd

         if (cInd > 0) then
            if (is_less_than(Group, cInd, mInd)) then
               mInd = cInd
            endif
            call find_min_alpha(Group, cInd-1, mInd)
         endif
        
      end subroutine find_min_alpha
    
      pure logical function is_less_than(Group, idx1, idx2)
         
         type(grp), intent(in) :: Group
         integer,   intent(in) :: idx1, idx2
        
         if (Group%Surname(idx1) < Group%Surname(idx2)) then
            is_less_than = .true.
         else if (Group%Surname(idx1) == Group%Surname(idx2)) then
            is_less_than = (Group%Initials(idx1) < Group%Initials(idx2))
         else
            is_less_than = .false.
         endif
        
      end function is_less_than

   end function find_first_by_alphabet

   function find_younger(Group) result(younger_ind)

      type(grp), intent(in) :: Group
      integer               :: younger_ind, n

      n = size(Group%Year)
      younger_ind = n
      call get_year(Group, n-1, younger_ind)
         
   contains
      
      pure recursive subroutine get_year(Group, cInd, mInd)
      
         type(grp), intent(in)    :: Group
         integer,   intent(in)    :: cInd
         integer,   intent(inout) :: mInd

         if(cInd > 0) then
            if(Group%Year(mInd) > Group%Year(cInd)) then
               mInd = cInd
            endif
            call get_year(Group, cInd-1, mInd)
         endif
         
      end subroutine get_year
      
   end function find_younger

end module Process   
