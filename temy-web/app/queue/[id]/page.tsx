"use client";

import { useEffect, useState } from "react";
import Image from "next/image";
import { useParams } from "next/navigation";
import { GuestService } from "@/services/guest-service";
import { ReservationData, QueueStatusResponse } from "@/types/api-types";
import { apiClient } from "@/lib/api-client"; // Need direct access for custom endpoints if service missing
import { ENDPOINTS } from "@/lib/api-endpoints";

import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";

export default function QueuePositionPage() {
    const params = useParams(); // params.id = reservationId
    const [reservation, setReservation] = useState<ReservationData | null>(null);
    const [positionData, setPositionData] = useState<any>(null); // QueuePositionResponse data
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchPosition = async () => {
            try {
                const id = Array.isArray(params.id) ? params.id[0] : params.id;
                if (!id) return;

                // Fetch Queue Position 
                // Need to implement getQueuePosition in GuestService or QueueService
                // For now using direct axios call as I might have missed adding it to GuestService
                const response = await apiClient.get(ENDPOINTS.QUEUE.POSITION(id));
                if (response.data && response.data.data) {
                    setPositionData(response.data.data);
                    setReservation(response.data.data.reservation);
                }
            } catch (error) {
                console.error("Failed to fetch queue position", error);
            } finally {
                setLoading(false);
            }
        };

        fetchPosition();
        // Poll every 30 seconds
        const interval = setInterval(fetchPosition, 30000);
        return () => clearInterval(interval);
    }, [params.id]);

    if (loading) {
        return (
            <div className="container mx-auto p-4 flex flex-col items-center justify-center min-h-[50vh] space-y-4">
                <Skeleton className="h-12 w-3/4" />
                <Skeleton className="h-48 w-full max-w-md rounded-xl" />
            </div>
        );
    }

    if (!positionData) {
        return <div className="container mx-auto p-4 text-center">Reservation not found.</div>;
    }

    return (
        <div className="container mx-auto p-4 flex flex-col items-center min-h-screen bg-gray-50 pt-10">
            <Card className="w-full max-w-md shadow-xl border-primary/20">
                <CardHeader className="text-center bg-primary/5 pb-8 pt-8">
                    <CardTitle className="text-3xl font-bold text-primary">
                        #{positionData.reservation.queue_number}
                    </CardTitle>
                    <CardDescription className="text-lg">
                        Your Queue Number
                    </CardDescription>
                </CardHeader>
                <CardContent className="space-y-6 pt-6">
                    <div className="text-center space-y-2">
                        <p className="text-sm text-muted-foreground uppercase tracking-wide">Current Status</p>
                        <Badge variant={positionData.queueStatus === "waiting" ? "secondary" : "default"} className="text-lg px-4 py-1">
                            {positionData.queueStatus?.toUpperCase() || "UNKNOWN"}
                        </Badge>
                    </div>

                    <div className="grid grid-cols-2 gap-4 text-center">
                        <div className="p-4 bg-gray-100 rounded-lg">
                            <p className="text-2xl font-bold">{positionData.people_ahead}</p>
                            <p className="text-xs text-muted-foreground">People Ahead</p>
                        </div>
                        <div className="p-4 bg-gray-100 rounded-lg">
                            {/* Estimated time calculation often depends on avg time * people ahead */}
                            {/* Assuming backend provides it or we calc it manually */}
                            <p className="text-2xl font-bold">~{positionData.people_ahead * 20}m</p>
                            <p className="text-xs text-muted-foreground">Est. Wait</p>
                        </div>
                    </div>

                    <div className="border-t pt-4">
                        <div className="flex items-center gap-4 mb-4">
                            <div className="w-12 h-12 rounded-full overflow-hidden relative bg-gray-200">
                                {/* Barber Avatar */}
                                {/* Note: Check if positionData.reservation.barber has details */}
                            </div>
                            <div>
                                <p className="font-semibold">Barber Shop</p>
                                <p className="text-sm text-muted-foreground">You are in line.</p>
                            </div>
                        </div>

                        <div className="space-y-2">
                            {positionData.reservation.services?.map((service: any) => (
                                <div key={service._id || service.id} className="flex justify-between text-sm">
                                    <span>{service.name}</span>
                                    <span>{service.price} SAR</span>
                                </div>
                            ))}
                            <div className="flex justify-between font-bold pt-2 border-t mt-2">
                                <span>Total</span>
                                <span>{positionData.reservation.totalPrice} SAR</span>
                            </div>
                        </div>
                    </div>
                </CardContent>
            </Card>

            <div className="mt-8">
                <Button variant="outline" onClick={() => window.location.reload()}>Refresh Status</Button>
            </div>
        </div>
    );
}
