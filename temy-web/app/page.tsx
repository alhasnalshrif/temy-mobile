// ... imports
import Link from "next/link";
import { Card, CardContent } from "@/components/ui/card";
import { HomeService } from "@/services/home-service";
import Image from "next/image";
import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@/components/ui/carousel";

export default async function Home() {
  const [bannersData, categoriesData] = await Promise.all([
    HomeService.getBanners(),
    HomeService.getCategories(),
  ]);

  const banners = bannersData.data || [];
  const categories = categoriesData.data || [];

  return (
    <div className="container mx-auto px-4 py-8 space-y-12">
      <section className="space-y-4">
        <h2 className="text-3xl font-extrabold tracking-tight text-gray-900">Featured</h2>
        <div className="w-full">
          <Carousel className="w-full">
            <CarouselContent>
              {banners.map((banner, index) => (
                <CarouselItem key={index} className="md:basis-1/2 lg:basis-1/3 p-2">
                  <div className="relative aspect-[16/9] rounded-2xl overflow-hidden shadow-lg hover:shadow-xl transition-shadow duration-300">
                    <Image
                      src={banner.image}
                      alt={`Banner ${index}`}
                      fill
                      className="object-cover hover:scale-105 transition-transform duration-500"
                      unoptimized
                    />
                  </div>
                </CarouselItem>
              ))}
            </CarouselContent>
            <CarouselPrevious className="left-2" />
            <CarouselNext className="right-2" />
          </Carousel>
        </div>
      </section>

      <section className="space-y-8">
        <div className="flex items-center justify-between">
          <h2 className="text-4xl font-black tracking-tight text-gray-900">
            Browse Categories
          </h2>
        </div>

        <div className="grid grid-cols-2 lg:grid-cols-4 gap-6">
          {categories.map((category) => (
            <Link
              key={category._id || category.id}
              href={`/category/${category._id || category.id}`}
              className="group relative block aspect-[4/5] overflow-hidden rounded-3xl bg-gray-100 shadow-lg transition-all duration-500 hover:shadow-2xl hover:-translate-y-2"
            >
              <Image
                src={category.imageCover || ""}
                alt={category.name || "Category"}
                fill
                className="object-cover transition-transform duration-700 group-hover:scale-110"
                unoptimized
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black via-black/20 to-transparent opacity-60 transition-opacity duration-500 group-hover:opacity-40" />
              <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-80" />

              <div className="absolute bottom-0 left-0 w-full p-6 text-white transform transition-transform duration-300">
                <div className="overflow-hidden">
                  <h3 className="text-2xl font-bold translate-y-0 transition-transform duration-300 group-hover:-translate-y-1">
                    {category.name}
                  </h3>
                  <div className="h-1 w-12 bg-white/80 rounded full mt-2 transition-all duration-300 group-hover:w-full group-hover:bg-primary" />
                  {category.description && (
                    <p className="mt-2 text-sm text-gray-200 line-clamp-2 opacity-0 transform translate-y-4 transition-all duration-300 group-hover:opacity-100 group-hover:translate-y-0">
                      {category.description}
                    </p>
                  )}
                </div>
              </div>
            </Link>
          ))}
        </div>
      </section>
    </div>
  );
}
