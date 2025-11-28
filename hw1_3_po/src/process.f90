module Process

   use Environment
   use Config
   use omp_lib

   implicit none

contains

   function find_first_by_alphabet(Group) result(first_ind)
   
      type(student), intent(in) :: Group(:)
      integer                   :: first_ind

      integer                   :: i, id, n, local_min_index, &
                                   num_threads, Rind, Lind, &
                                   data_delimeter
    
      num_threads = omp_get_max_threads()
      call omp_set_num_threads(num_threads)
      n = size(Group)
      data_delimeter = n / num_threads 
      first_ind = 1

      !$OMP PARALLEL PRIVATE(local_min_index, id, i, Rind, Lind) &
      !$OMP SHARED(first_ind, Group, n, data_delimeter, num_threads)
          
         id = omp_get_thread_num()
         if (id == num_threads) then
            Rind = n
         else
            Rind = data_delimeter * (id + 1)
         endif
  
         Lind = data_delimeter * id + 1

         local_min_index = Lind
         
         !$OMP DO
         do i = Lind + 1, Rind
            if (Group(i)%Surname < Group(local_min_index)%Surname) then
               local_min_index = i
            else if (Group(i)%Surname == Group(local_min_index)%Surname) then
               if (Group(i)%Initials < Group(local_min_index)%Initials) then
                  local_min_index = i
               endif
            endif
         end do
         !$OMP END DO
          
         !$OMP CRITICAL
         if (Group(local_min_index)%Surname < Group(first_ind)%Surname) then
            first_ind = local_min_index
         else if (Group(local_min_index)%Surname == Group(first_ind)%Surname) then
            if (Group(local_min_index)%Initials < Group(first_ind)%Initials) then
               first_ind = local_min_index  
            endif
         endif
         !$OMP END CRITICAL

      !$OMP END PARALLEL

   end function find_first_by_alphabet   

   function find_younger(Group) result(younger_ind)

      type(student), intent(in) :: Group(:)
      integer                   :: younger_ind

      integer             :: i, id, i_min, n, &
                             num_threads, Lind, Rind, &
                             data_delimeter

      n = size(Group)
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
            if (Group(i)%Year < Group(i_min)%Year) then
               i_min = i
            end if
         end do
         !$OMP END DO

         !$OMP critical
            if (Group(i_min)%Year < Group(younger_ind)%Year) then
               younger_ind = i_min
            end if
         !$OMP END critical

      !$OMP END PARALLEL

   end function find_younger

end module Process   
