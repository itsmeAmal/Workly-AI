//
//  DashboardView.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-01.
//



import SwiftUI

// MARK: - Dashboard View
struct DashboardView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Greeting Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Hi, Devindi")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Here’s your dashboard")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)

                    // Stats Grid (2x2)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        StatCard(title: "Job Matches", value: "24", systemImage: "briefcase")
                        StatCard(title: "Applications", value: "6", systemImage: "doc.plaintext")
                        StatCard(title: "Interviews", value: "2", systemImage: "person.2.circle")
                        StatCard(title: "Profile", value: "85%", systemImage: "person.crop.circle.badge.checkmark", showProgress: true, progress: 0.85)
                    }
                    .padding(.horizontal)

                    // Upcoming Interview Section
                    SectionHeader(title: "Upcoming Interview")
                        .padding(.horizontal)
                    InterviewCard(company: "Sitecore", role: "Junior DevOps Engineer", date: "Apr 25, 2025", time: "10:00 AM")
                        .padding(.horizontal)

                    // Recommended Jobs Section
                    SectionHeader(title: "Recommended Jobs")
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(sampleJobs) { job in
                                JobCard(job: job)
                            }
                        }
                        .padding(.horizontal)
                    }

                    Spacer(minLength: 32)
                }
                .padding(.vertical)
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Stat Card
struct StatCard: View {
    let title: String
    let value: String
    let systemImage: String
    var showProgress: Bool = false
    var progress: Double = 0

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.system(size: 28))
                .padding(12)
                .background(Color.blue.opacity(0.15))
                .clipShape(Circle())
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            if showProgress {
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle())
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: Color.primary.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Section Header
struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.semibold)
    }
}

// MARK: - Interview Card
struct InterviewCard: View {
    let company: String
    let role: String
    let date: String
    let time: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(company)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(role)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                HStack {
                    Label(date, systemImage: "calendar")
                    Label(time, systemImage: "clock")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: Color.primary.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Job Model
struct Job: Identifiable {
    let id = UUID()
    let company: String
    let role: String
    let location: String
}

let sampleJobs: [Job] = [
    Job(company: "Apple", role: "iOS Engineer", location: "Cupertino, CA"),
    Job(company: "Google", role: "SRE", location: "Mountain View, CA"),
    Job(company: "Meta", role: "Frontend Engineer", location: "Menlo Park, CA")
]

// MARK: - Job Card
struct JobCard: View {
    let job: Job

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(job.company)
                .font(.headline)
                .fontWeight(.bold)
            Text(job.role)
                .font(.subheadline)
            Text(job.location)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(width: 200, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: Color.primary.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Preview
#Preview {
    DashboardView()
}
