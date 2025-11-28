module Process

   use Environment
   use Config
   use omp_lib

   implicit none

contains
   
   function find_first_by_alphabet(Surnames, Initials) result(first_ind)

      character(kind=CH_), intent(in) :: Surnames(:,:)
      character(kind=CH_), intent(in) :: Initials(:,:)

      integer                         :: first_ind
   
      integer                         :: row, comp, Rind, Lind, &
                                         loc_min, id, data_delimeter, &
                                         num_threads, n
      first_ind = 1
      n = size(Surnames, dim=1)

      num_threads = omp_get_max_threads()
      call omp_set_num_threads(num_threads)
      data_delimeter = n / num_threads
      
      !$OMP PARALLEL private(id, row, Rind, Lind, loc_min, comp) &
      !$OMP shared (Surnames, Initials, first_ind, data_delimeter, num_threads, n)
         
         id = omp_get_thread_num()
         if (id == num_threads) then
            Rind = n
         else
            Rind = data_delimeter * (id + 1)
         endif
  
         Lind = data_delimeter * id + 1
         loc_min = Lind

         !$OMP DO 
         do row = Lind + 1, Rind
            comp = compare_names(Surnames(loc_min, :), Surnames(row, :)) 
            if (comp == 1) then
              loc_min = row
            elseif (comp == 0) then
               comp = compare_names(Initials(loc_min, :), Initials(row, :))
               if(comp == 1) then
                  loc_min = row
               endif
            endif
         end do
         !$OMP END DO

         !$OMP critical
         comp = compare_names(Surnames(first_ind, :), Surnames(loc_min, :)) 
         if (comp == 1) then
            first_ind = loc_min
         elseif (comp == 0) then
            comp = compare_names(Initials(first_ind, :), Initials(loc_min, :))
            if (comp == 1) then
               first_ind = loc_min
            endif
         endif
         !$OMP END critical
        
      !$OMP END PARALLEL

   contains
      
      function compare_names(First_Name, Second_Name) result(compare)
         
         character(kind=CH_), intent(in)           :: First_Name(:), Second_Name(:)
         integer                                   :: compare
         
         integer                                   :: first_diff
         logical, allocatable                      :: Comp_Mask(:)
   
         !allocate(Comp_Mask(size(First_Name)))
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

      integer             :: i, id, i_min, n, &
                             num_threads, Lind, Rind, &
                             data_delimeter

      n = size(Year)
      younger_ind = 1

      num_threads = omp_get_max_threads()
      call omp_set_num_threads(num_threads)
      data_delimeter = n / num_threads
      
      !$OMP PARALLEL private(id, i_min, i, Lind, Rind) &
      !$OMP shared(Year, n, younger_ind, data_delimeter, num_threads)
         
         id = omp_get_thread_num()
         if (id == num_threads) then
            Rind = n
         else
            Rind = data_delimeter * (id + 1)
         endif
  
         Lind = data_delimeter * id + 1

         i_min = Lind
         
         !$OMP DO
         do i = Lind+1, Rind
            if (Year(i) < Year(i_min)) then
               i_min = i
            end if
         end do
         !$OMP END DO

         !$OMP critical
            if (Year(i_min) < Year(younger_ind)) then
               younger_ind = i_min
            end if
         !$OMP END critical

      !$OMP END PARALLEL

   end function find_younger

end module Process   
