## Contoh Pola Silence (PAU/SIL) Full Label

### Catatan: Prosidy tidak dicantumkan

### Konten asli 
- contoh
~~~
       0    1500000 x^x-pau+pau=pau@
 1500000    4500000 x^pau-pau+pau=pau@
 4500000    7150000 pau^pau-pau+pau=a@
 7150000    9650000 pau^pau-pau+a=y@
 9650000   11450000 pau^pau-a+y=o@
11450000   14000000 pau^a-y+o=c@
14000000   23800001 a^y-o+c=e@
23800001   24600000 y^o-c+e=p@
24600000   24800000 o^c-e+p=a@
24800000   26250000 c^e-p+a=t@
26250000   30699999 e^p-a+t=pau@
30699999   31150000 p^a-t+pau=pau@
31150000   32650001 a^t-pau+pau=pau@
32650001   35650001 t^pau-pau+pau=x@
35650001   37800000 pau^pau-pau+x=x@
~~~

### awalan yang dibuang
- semua baris yang sisi kiri sama dengan (=) hanya berisi pau, ```x^pau```, atau ```x^x```.
~~~
       0    1500000 x^x-pau+pau=pau@
 1500000    4500000 x^pau-pau+pau=pau@
 4500000    7150000 pau^pau-pau+pau=a@
~~~

### modifikasi sebagian pau ke x di awal kalimat
- ```pau^pau-pau``` menjadi ```x^x-pau```
- ```pau^pau``` menjadi ```x^pau```
- contoh sebelum modifikasi
~~~
 7150000    9650000 pau^pau-pau+a=y@
 9650000   11450000 pau^pau-a+y=o@
11450000   14000000 pau^a-y+o=c@
~~~
- contoh sesudah modifikasi
~~~
 7150000    9650000 x^x-pau+a=y@
 9650000   11450000 x^pau-a+y=o@
11450000   14000000 pau^a-y+o=c@
~~~

### konten inti
- contoh
~~~
14000000   23800001 a^y-o+c=e@
23800001   24600000 y^o-c+e=p@
24800000   26250000 c^e-p+a=t@
26250000   30699999 e^p-a+t=pau@
~~~

### modifikasi sebagian pau ke x di akhir kalimat
- ```+pau=pau``` menjadi ```+pau=x```
- ```-pau+pau=pau``` menjadi ```-pau+x+x```
- contoh sebelum modifikasi
~~~
30699999   31150000 p^a-t+pau=pau@
31150000   32650001 a^t-pau+pau=pau@
~~~
- contoh sesudah modifikasi
~~~
30699999   31150000 p^a-t+pau=x@
31150000   32650001 a^t-pau+x=x@
~~~

### sisa di akhir kalimat dibuang
- contoh
~~~
32650001   35650001 t^pau-pau+pau=x@
35650001   37800000 pau^pau-pau+x=x@
~~~
