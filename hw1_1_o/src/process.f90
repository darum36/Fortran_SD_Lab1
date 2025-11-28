module Process

   use Environment
   use Config
   use omp_lib

   implicit none

contains

   function find_first_by_alphabet(Surnames, Initials) result(first_ind)
      
      character(SURNAME_LEN, kind=CH_),  intent(in), allocatable :: Surnames(:)
      character(INITIALS_LEN, kind=CH_), intent(in), allocatable :: Initials(:)
   
      integer                                       :: first_ind
    
      integer                                       :: i, id, n, loc_min, &
                                                       num_threads, Rind, Lind, &
                                                       data_delimeter
    
      ! Получаем количество потоков
      num_threads = omp_get_max_threads()
      call omp_set_num_threads(num_threads)
      
      ! Делим данные между потоками
      n = size(Surnames)
      data_delimeter = n / num_threads 
      first_ind = 1

      !$OMP PARALLEL PRIVATE(loc_min, id, i, Rind, Lind) &
      !$OMP SHARED(first_ind, Surnames, Initials, n, data_delimeter, num_threads)
          
         ! Определяем левую и правую границу данных для потока
         id = omp_get_thread_num()
         if (id == num_threads) then
            Rind = n
         else
            Rind = data_delimeter * (id + 1)
         endif
  
         Lind = data_delimeter * id + 1

         loc_min = Lind
         
         print *, "Запустился поток для фамилий:", id, "L:", Lind, "R:", Rind
          
         ! Параллельный цикл
         !$OMP DO
         do i = Lind + 1, Rind
            if (Surnames(i) < Surnames(loc_min)) then
               loc_min = i
            else if (Surnames(i) == Surnames(loc_min)) then
               if (Initials(i) < Initials(loc_min)) then
                  loc_min = i
               endif
            endif
         end do
         !$OMP END DO

         !$OMP CRITICAL
            if (Surnames(loc_min) < Surnames(first_ind)) then
               first_ind = loc_min 
            else if (Surnames(loc_min) == Surnames(first_ind)) then
               if (Initials(loc_min) < Initials(first_ind)) then
                  first_ind = loc_min
               endif
            endif
         !$OMP END CRITICAL
          
      !$OMP END PARALLEL
       
   end function find_first_by_alphabet

   function find_younger(Year) result(younger_ind)

      integer, intent(in), allocatable :: Year(:)
      integer                          :: younger_ind

      integer             :: i, id, i_min, n, &
                             num_threads, Lind, Rind, &
                             data_delimeter

      ! Получаем количество потоков
      num_threads = omp_get_max_threads()
      call omp_set_num_threads(num_threads)
      
      ! Делим данные между потоками
      n = size(Year)
      data_delimeter = n / num_threads 
      younger_ind = 1
      
      !$OMP PARALLEL private(id, i_min, i, Lind, Rind) &
      !$OMP shared(Year, n, younger_ind, data_delimeter)
         
         ! Определяем левую и правую границу данных для потока
         id = omp_get_thread_num()
         if (id == num_threads) then
            Rind = n
         else
            Rind = data_delimeter * (id + 1)
         endif
  
         Lind = data_delimeter * id + 1

         i_min = Lind
         print * , "Запустился поток для года:", id, "L:", Lind, "R:", Rind
         
         ! Параллельный цикл
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
