module Process

   use Environment
   use Config
   use omp_lib

   implicit none

contains

   function find_first_by_alphabet(Group) result(first_ind)
   
      type(grp), intent(in) :: Group
      integer               :: first_ind

      integer               :: i, id, loc_min, n, &
                               num_threads, Lind, Rind, &
                               data_delimeter

      first_ind = 1
      n = size(Group%Year)
    
      num_threads = omp_get_max_threads()
      call omp_set_num_threads(num_threads)
      data_delimeter = n / num_threads
      
      !$OMP PARALLEL private(id, i, Rind, Lind, loc_min) &
      !$OMP shared (Group, first_ind, data_delimeter, num_threads, n)      
      
         id = omp_get_thread_num()
         if (id == num_threads) then     
            Rind = n       
         else              
            Rind = data_delimeter * (id + 1)
         endif             
   
         Lind = data_delimeter * id + 1
         loc_min = Lind 

         !$OMP DO
         do i = Lind + 1, Rind
            if (Group%Surname(i) < Group%Surname(loc_min)) then
               loc_min = i
            else if (Group%Surname(i) == Group%Surname(loc_min)) then
               if (Group%Initials(i) < Group%Initials(loc_min)) then
                  loc_min = i
               end if
            end if
         end do
         !$OMP END DO 

         !$OMP critical
         if (Group%Surname(loc_min) < Group%Surname(first_ind)) then
            first_ind = loc_min
         else if (Group%Surname(loc_min) == Group%Surname(first_ind)) then
            if (Group%Initials(loc_min) < Group%Initials(first_ind)) then
               first_ind = loc_min
            end if
         end if
         !$OMP END critical

      !$OMP END PARALLEL
      
   end function find_first_by_alphabet   

   function find_younger(Group) result(younger_ind)

      type(grp), intent(in) :: Group
      integer               :: younger_ind

      integer               :: i, id, i_min, n, &
                               num_threads, Lind, Rind, &
                               data_delimeter

      n = size(Group%Year)
      younger_ind = 1

      num_threads = omp_get_max_threads()
      call omp_set_num_threads(num_threads)
      data_delimeter = n / num_threads
      
      !$OMP PARALLEL private(id, i_min, i, Lind, Rind) &
      !$OMP shared(Group, n, younger_ind, data_delimeter)
         
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
            if (Group%Year(i) < Group%Year(i_min)) then
               i_min = i
            end if
         end do
         !$OMP END DO

         !$OMP critical
            if (Group%Year(i_min) < Group%Year(younger_ind)) then
               younger_ind = i_min
            end if
         !$OMP END critical

      !$OMP END PARALLEL

   end function find_younger

end module Process   
